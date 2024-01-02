import random
import string

from django.contrib.auth.base_user import AbstractBaseUser
from django.contrib.auth.models import AbstractUser, PermissionsMixin
from django.db import models

from common.models import uuid_string, BaseModel
from workout_auths.workout_user_manager import UserManager


class WorkoutUserModel(AbstractBaseUser, PermissionsMixin):
    class LoginPlatform(models.TextChoices):
        KAKAO = ("kakao", "Kakao")
        GOOGLE = ("google", "Google")
        APPLE = ("apple", "Apple")
        WORKOUT = ("workout", "Workout")

    class GenderChoices(models.TextChoices):
        MALE = ("male", "Male")
        FEMALE = ("female", "Female")
        NONE = ("none", "None")

    class Meta:
        db_table = "workout_users"
        managed = True
        unique_together = (("email", "nickname"),)

    objects = UserManager()

    USERNAME_FIELD = "nickname"
    REQUIRED_FIELDS = ["email"]

    uuid = models.CharField(max_length=32, default=uuid_string, unique=True)
    nickname = models.CharField(unique=True, max_length=255, blank=True, null=True)
    username = models.CharField(unique=False, max_length=255)
    phone_number = models.CharField(unique=False, max_length=255, null=True)
    email = models.EmailField(
        max_length=255,
        unique=False,
        null=False,
    )
    password = models.CharField(max_length=255, blank=True, null=True)
    login_platform = models.CharField(
        max_length=255,
        choices=LoginPlatform.choices,
        null=False,
    )
    gender = models.CharField(
        max_length=255,
        choices=GenderChoices.choices,
        default=GenderChoices.NONE,
    )

    refresh_token = models.TextField(blank=True, null=True)
    is_active = models.BooleanField(default=True)
    is_admin = models.BooleanField(default=False)
    is_superuser = models.BooleanField(default=False)
    is_staff = models.BooleanField(default=False)
    date_joined = models.DateTimeField(auto_now_add=True)
