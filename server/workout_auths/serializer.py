from rest_framework_simplejwt.serializers import TokenObtainPairSerializer


class WorkoutTokenCustomSerializer(TokenObtainPairSerializer):
    default_error_messages = {
        "no_active_account": {
            "result": None,
            "message": "사용자 정보가 올바르지 않습니다.",
            "data": [],
        },
    }

    @classmethod
    def get_token(cls, user):
        token = super().get_token(user)

        # Add custom claims
        token["nickname"] = user.nickname
        token["phone_number"] = user.phone_number
        token["gender"] = user.gender

        return token

    def validate(self, attrs):
        data = super(WorkoutTokenCustomSerializer, self).validate(attrs)
        refresh_token = str(self.get_token(self.user))

        self.user.refresh_token = refresh_token

        data["refresh"] = refresh_token
        data["nickname"] = self.user.nickname
        data["phone_number"] = self.user.phone_number
        data["gender"] = self.user.gender

        result = dict()
        result["data"] = data
        result["message"] = "로그인에 성공했습니다."
        result["success"] = True
        self.user.save()
        return result
