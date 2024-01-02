from rest_framework import status, permissions
from rest_framework.views import APIView
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView

from common.global_response import WorkoutResponse
from workout_auths.serializer import WorkoutTokenCustomSerializer


# Create your views here.
class WorkoutRefreshTokenPairView(TokenRefreshView):
    permission_classes = (permissions.AllowAny,)
    serializer_class = WorkoutTokenCustomSerializer


class WorkoutTokenPairView(TokenObtainPairView):
    permission_classes = (permissions.AllowAny,)
    serializer_class = WorkoutTokenCustomSerializer


class MyAPIView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request, *args, **kwargs):
        data = {"key": "value"}  # Your logic here
        return WorkoutResponse(data=data, res_status=status.HTTP_200_OK)

    def post(self, request, *args, **kwargs):
        # Process the request data

        return WorkoutResponse(
            data={"message": "Data processed"},
            res_status=status.HTTP_201_CREATED,
        )
