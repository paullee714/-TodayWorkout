from django.urls import path
from rest_framework_simplejwt.views import (
    TokenVerifyView,
)

from workout_auths.views import (
    WorkoutTokenPairView,
    WorkoutRefreshTokenPairView,
    VerifyMeView,
)

urlpatterns = [
    path(
        "token",
        WorkoutTokenPairView.as_view(),
        name="token_obtain_pair",
    ),
    path(
        "token/refresh",
        WorkoutRefreshTokenPairView.as_view(),
        name="token_refresh",
    ),
    path("token/verify", TokenVerifyView.as_view(), name="token_verify"),
    path("verify-me", VerifyMeView.as_view(), name="verify_me"),
]
