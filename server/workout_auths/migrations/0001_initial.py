# Generated by Django 5.0 on 2024-01-02 14:39

import common.models
import workout_auths.workout_user_manager
from django.db import migrations, models


class Migration(migrations.Migration):
    initial = True

    dependencies = [
        ("auth", "0012_alter_user_first_name_max_length"),
    ]

    operations = [
        migrations.CreateModel(
            name="WorkoutUserModel",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                (
                    "last_login",
                    models.DateTimeField(
                        blank=True, null=True, verbose_name="last login"
                    ),
                ),
                (
                    "uuid",
                    models.CharField(
                        default=common.models.uuid_string, max_length=32, unique=True
                    ),
                ),
                (
                    "nickname",
                    models.CharField(
                        blank=True, max_length=255, null=True, unique=True
                    ),
                ),
                ("username", models.CharField(max_length=255)),
                ("phone_number", models.CharField(max_length=255, null=True)),
                ("email", models.EmailField(max_length=255)),
                ("password", models.CharField(blank=True, max_length=255, null=True)),
                (
                    "login_platform",
                    models.CharField(
                        choices=[
                            ("kakao", "Kakao"),
                            ("google", "Google"),
                            ("apple", "Apple"),
                            ("workout", "Workout"),
                        ],
                        max_length=255,
                    ),
                ),
                (
                    "gender",
                    models.CharField(
                        choices=[
                            ("male", "Male"),
                            ("female", "Female"),
                            ("none", "None"),
                        ],
                        default="none",
                        max_length=255,
                    ),
                ),
                ("refresh_token", models.TextField(blank=True, null=True)),
                ("is_active", models.BooleanField(default=True)),
                ("is_admin", models.BooleanField(default=False)),
                ("is_superuser", models.BooleanField(default=False)),
                ("is_staff", models.BooleanField(default=False)),
                ("date_joined", models.DateTimeField(auto_now_add=True)),
                (
                    "groups",
                    models.ManyToManyField(
                        blank=True,
                        help_text="The groups this user belongs to. A user will get all permissions granted to each of their groups.",
                        related_name="user_set",
                        related_query_name="user",
                        to="auth.group",
                        verbose_name="groups",
                    ),
                ),
                (
                    "user_permissions",
                    models.ManyToManyField(
                        blank=True,
                        help_text="Specific permissions for this user.",
                        related_name="user_set",
                        related_query_name="user",
                        to="auth.permission",
                        verbose_name="user permissions",
                    ),
                ),
            ],
            options={
                "db_table": "workout_users",
                "managed": True,
                "unique_together": {("email", "nickname")},
            },
            managers=[
                ("objects", workout_auths.workout_user_manager.UserManager()),
            ],
        ),
    ]
