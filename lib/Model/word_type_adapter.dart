import 'package:flutter_application_1/Model/word_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class WordTypeAdapter extends TypeAdapter<WordModel> {
  @override
  WordModel read(BinaryReader reader) {
    return WordModel(
      indexAtDataBase: reader.readInt(),
      text: reader.readString(),
      isArabic: reader.readBool(),
      colorCode: reader.readInt(),
      arabicWord: reader.readStringList(),
      arabicExample: reader.readStringList(),
      englishExample: reader.readStringList(),
      englishWord: reader.readStringList(),
    );
  }

  @override
  // TODO: implement typeId
  int get typeId => throw UnimplementedError();

  @override
  void write(BinaryWriter writer, WordModel obj) {
    writer.writeInt(obj.indexAtDataBase);
    writer.writeString(obj.text);
    writer.writeInt(obj.colorCode);
    writer.writeBool(obj.isArabic);
    writer.writeStringList(obj.arabicExample);
    writer.writeStringList(obj.arabicWord);
    writer.writeStringList(obj.englishExample);
    writer.writeStringList(obj.englishWord);
  }
}
