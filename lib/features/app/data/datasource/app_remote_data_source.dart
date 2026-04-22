abstract class AppRemoteDataSource {
  Future<bool> isLoggedIn();
}

class AppRemoteDataSourceImplWithFireBase implements AppRemoteDataSource {
  @override
  Future<bool> isLoggedIn() {
    // TODO: implement isLoggedIn
    throw UnimplementedError();
  }
}