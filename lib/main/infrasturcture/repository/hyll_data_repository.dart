import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hyll/main/domain/model/adventure_model.dart';
import 'package:hyll/main/domain/model/failure.dart';
import 'package:hyll/main/domain/model/hyll_model.dart';

class HyllDataRepository {
  final Dio dio;
  HyllDataRepository({required this.dio});

  Future<Either<Failure, HyllDataModel>> getData(String url) async {
    final Response<Map<String, dynamic>> response = await dio.get(
      url,
    );

    if (response.statusCode == 200) {
      return right(HyllDataModel.fromJson(response.data!));
    } else {
      return left(Failure(error: "error ${response.statusCode}"));
    }
  }

  Future<Either<Failure, AdventureModel>> getSingleData(String id) async {
    final Response<Map<String, dynamic>> response = await dio.get(
      "https://api.hyll.com/api/adventures/$id",
    );

    if (response.statusCode == 200) {
      return right(AdventureModel.fromJson(response.data!));
    } else {
      return left(Failure(error: "error ${response.statusCode}"));
    }
  }
}
