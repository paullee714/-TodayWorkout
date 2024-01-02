from django.urls import path
from rest_framework_simplejwt.views import (
    TokenObtainPairView,
    TokenRefreshView,
    TokenVerifyView,
)

from workout_auths.serializer import MyTokenObtainPairView
from workout_auths.views import MyAPIView

urlpatterns = [
    path("test", MyAPIView.as_view()),
    path(
        "token",
        MyTokenObtainPairView.as_view(),
        name="token_obtain_pair_test",
    ),
    # path("token", TokenObtainPairView.as_view(), name="token_obtain_pair"),
    path("token/refresh", TokenRefreshView.as_view(), name="token_refresh"),
    path("token/verify", TokenVerifyView.as_view(), name="token_verify"),
]
