from django.urls import path
from rest_framework_simplejwt.views import (
    TokenRefreshView,
    TokenVerifyView,
)

from workout_auths.views import MyAPIView, WorkoutTokenPairView

urlpatterns = [
    path("test", MyAPIView.as_view()),
    path(
        "token",
        WorkoutTokenPairView.as_view(),
        name="token_obtain_pair",
    ),
    # TODO: TokenRefreshView 상속
    path("token/refresh", TokenRefreshView.as_view(), name="token_refresh"),
    path("token/verify", TokenVerifyView.as_view(), name="token_verify"),
]
