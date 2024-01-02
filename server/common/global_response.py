from rest_framework.response import Response
from rest_framework import status

# def common_response(
#     data=None, status=HTTPStatus.OK, message=None, result=None
# ) -> JsonResponse:
#     if data is None:
#         data = []
#     return JsonResponse(
#         {
#             "result": result,
#             "message": message if message else status.phrase,
#             "data": data,
#         },
#         status=status,
#     )
#
#
# def unauthorized_response():
#     return common_response(
#         data=None,
#         result="fail",
#         message="사용자 정보가 일치하지 않습니다.",
#         status=HTTPStatus.UNAUTHORIZED,
#     )
#
#
# def internal_server_error(error_cause=None):
#     return common_response(
#         data=None,
#         result="fail",
#         message="INTERNAL SERVER ERROR" if error_cause is None else error_cause,
#         status=HTTPStatus.INTERNAL_SERVER_ERROR,
#     )
#
#
# def bad_request_response(error_cause=None):
#     return common_response(
#         data=None,
#         result="fail",
#         message="BAD REQUEST ERROR" if error_cause is None else error_cause,
#         status=HTTPStatus.BAD_REQUEST,
#     )


class WorkoutResponse(Response):
    def __init__(
        self,
        data=None,
        res_status=None,
        message=None,
    ):
        if res_status == status.HTTP_200_OK:
            message = "조회에 성공했습니다."
        elif res_status == status.HTTP_201_CREATED:
            message = "저장에 성공했습니다."
        else:
            if message is None:
                message = "에러가 발생했습니다."

        # Define your custom structure
        custom_data = {
            "success": True
            if res_status in [status.HTTP_200_OK, status.HTTP_201_CREATED]
            else False,
            "message": message,
            "data": data,
        }
        super().__init__(
            data=custom_data,
            status=res_status,
        )
