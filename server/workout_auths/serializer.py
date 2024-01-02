from rest_framework import permissions, serializers, status
from rest_framework.response import Response
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from rest_framework_simplejwt.views import TokenObtainPairView

from common.global_response import WorkoutResponse


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


class MyTokenObtainPairView(TokenObtainPairView):
    permission_classes = (permissions.AllowAny,)
    serializer_class = WorkoutTokenCustomSerializer

    # def post(self, request, *args, **kwargs):
    #     # Custom logic here
    #     response = super().post(request, *args, **kwargs)
    #     # Modify the response or perform other actions
    #
    #     if response.status_code == 200:
    #         # Access the serializer from the response data
    #         serializer = self.get_serializer(data=request.data)
    #
    #         # Validate the serializer to access user data
    #         if serializer.is_valid():
    #             print("####")
    #             print(response)
    #             print("####")
    #             user = serializer.user  # Access the user instance
    #             # Now you can access user's information, e.g., user.username, user.email, etc.
    #
    #             # You can modify the response data or perform other actions here
    #             # For example, adding user information to the response
    #             # custom_data = {
    #             #     "username": user.username,
    #             #     "email": user.email,
    #             #     # Add other user fields you might need
    #             # }
    #             # response.data.update(custom_data)
    #
    #     return response
