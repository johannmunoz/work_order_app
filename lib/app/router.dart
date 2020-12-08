import 'package:auto_route/auto_route_annotations.dart';
import 'package:work_order_app/ui/views/home/home_view.dart';
import 'package:work_order_app/ui/views/jobs/new_job/new_job_view.dart';
import 'package:work_order_app/ui/views/login/login_view.dart';
import 'package:work_order_app/ui/views/sign_up/sign_up_view.dart';
import 'package:work_order_app/ui/views/startup/startup_view.dart';

@MaterialRouter(routes: [
  MaterialRoute(page: StartupView, initial: true),
  MaterialRoute(page: HomeView),
  MaterialRoute(page: SignupView),
  MaterialRoute(page: LoginView),
  MaterialRoute(page: NewJobView),
])
class $Router {}
