# Generated by Django 5.0 on 2024-01-02 06:56

from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("workout_auths", "0003_alter_workoutusermodel_table"),
    ]

    operations = [
        migrations.AlterField(
            model_name="workoutusermodel",
            name="gender",
            field=models.CharField(
                choices=[("male", "Male"), ("female", "Female"), ("none", "None")],
                default="none",
                max_length=255,
            ),
        ),
    ]
