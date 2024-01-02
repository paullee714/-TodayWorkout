from rest_framework import permissions, status
from rest_framework.views import APIView
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView

from common.global_response import WorkoutResponse
from workout_auths.serializer import (
    WorkoutTokenCustomSerializer,
    WorkoutRefreshTokenCustomSerializer,
)


class WorkoutRefreshTokenPairView(TokenRefreshView):
    permission_classes = (permissions.AllowAny,)
    serializer_class = WorkoutRefreshTokenCustomSerializer


class WorkoutTokenPairView(TokenObtainPairView):
    permission_classes = (permissions.AllowAny,)
    serializer_class = WorkoutTokenCustomSerializer


class VerifyMeView(APIView):
    permission_classes = (permissions.IsAuthenticated,)

    def get(self, request, *args, **kwargs):
        return WorkoutResponse(
            data=[],
            res_status=status.HTTP_200_OK,
            message="this is good",
        )
