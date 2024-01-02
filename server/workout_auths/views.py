from rest_framework import permissions
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView

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
