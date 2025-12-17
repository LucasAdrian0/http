import 'package:shared_preferences/shared_preferences.dart';

enum STORAGE_CHAVES {
  CHAVE_DADOS_CADASTRAIS_NOME,
  CHAVE_DADOS_CADASTRAIS_DATA_NASCIMENTO,
  CHAVE_DADOS_CADASTRAIS_NIVEL_EXPERIENCIA,
  CHAVE_DADOS_CADASTRAIS_LINGUAGENS,
  CHAVE_DADOS_CADASTRAIS_TEMPO_EXPERIENCIA,
  CHAVE_DADOS_CADASTRAIS_SALARIO,
  CHAVE_NOME_USUARIO,
  CHAVE_ALTURA,
  CHAVE_RECEBER_NOTIFICACAO,
  CHAVE_TEMA_ESCURO,
}

class AppStorageService {
  Future<void> setConfiguracoesNomeUsuario(String nome) async {
    await _setString(STORAGE_CHAVES.CHAVE_NOME_USUARIO.toString(), nome);
  }

  Future<String> getConfiguracoesNomeUsuario() async {
    return _getString(STORAGE_CHAVES.CHAVE_NOME_USUARIO.toString());
  }

  Future<void> setConfiguracoesAltura(String nome) async {
    await _setString(STORAGE_CHAVES.CHAVE_ALTURA.toString(), nome);
  }

  Future<double> getConfiguracoesAltura() async {
    return _getDouble(STORAGE_CHAVES.CHAVE_ALTURA.toString());
  }

  Future<void> setConfiguracoesReceberNotificacao(bool value) async {
    await _setBool(STORAGE_CHAVES.CHAVE_RECEBER_NOTIFICACAO.toString(), value);
  }

  Future<bool> getConfiguracoesReceberNotificacao() async {
    return _getBool(STORAGE_CHAVES.CHAVE_RECEBER_NOTIFICACAO.toString());
  }

  Future<void> setConfiguracoesTemaEscuro(bool value) async {
    await _setBool(STORAGE_CHAVES.CHAVE_TEMA_ESCURO.toString(), value);
  }

  Future<bool> getConfiguracoesTemaEscuro() async {
    return _getBool(STORAGE_CHAVES.CHAVE_TEMA_ESCURO.toString());
  }

  //******************************************************************/

  Future<void> setDadosCadastraisNome(String nome) async {
    return _setString(
      STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_NOME.toString(),
      nome,
    );
  }

  Future<String> getDadosCadastraisNome() async {
    return _getString(STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_NOME.toString());
  }

  Future<void> setDadosCadastraisDataNascimento(DateTime data) async {
    await _setString(
      STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_DATA_NASCIMENTO.toString(),
      data.toString(),
    );
  }

  Future<String> getDadosCadastraisDataNascimento() async {
    return _getString(
      STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_DATA_NASCIMENTO.toString(),
    );
  }

  Future<void> setDadosCadastraisNivelExperiencia(
    String nivelExperiencia,
  ) async {
    await _setString(
      STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_NIVEL_EXPERIENCIA.toString(),
      nivelExperiencia,
    );
  }

  Future<String> getDadosCadastraisNivelExperiencia() async {
    return _getString(
      STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_NIVEL_EXPERIENCIA.toString(),
    );
  }

  Future<void> setDadosCadastraisLinguagem(List<String> values) async {
    await _setStringList(
      STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_LINGUAGENS.toString(),
      values,
    );
  }

  Future<List<String>> getDadosCadastraisLinguagem() async {
    return _getStringList(
      STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_LINGUAGENS.toString(),
    );
  }

  Future<void> setDadosCadastraisTempoExperiencia(int value) async {
    await _setInt(
      STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_TEMPO_EXPERIENCIA.toString(),
      value,
    );
  }

  Future<int> getDadosCadastraisTempoExperiencia() async {
    return _getInt(
      STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_TEMPO_EXPERIENCIA.toString(),
    );
  }

  Future<void> setDadosCadastraisSalario(double value) async {
    await _setDouble(
      STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_SALARIO.toString(),
      value,
    );
  }

  Future<double> getDadosCadastraisSalario() async {
    return _getDouble(STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_SALARIO.toString());
  }

  _setString(String chave, String value) async {
    var storage = await SharedPreferences.getInstance();
    storage.setString(chave, value);
  }

  Future<String> _getString(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getString(chave) ?? "";
  }

  _setStringList(String chave, List<String> values) async {
    var storage = await SharedPreferences.getInstance();
    storage.setStringList(chave, values);
  }

  Future<List<String>> _getStringList(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getStringList(chave) ?? [];
  }

  _setInt(String chave, int value) async {
    var storage = await SharedPreferences.getInstance();
    storage.setInt(chave, value);
  }

  Future<int> _getInt(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getInt(chave) ?? 0;
  }

  _setDouble(String chave, double value) async {
    var storage = await SharedPreferences.getInstance();
    storage.setDouble(chave, value);
  }

  Future<double> _getDouble(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getDouble(chave) ?? 0;
  }

  _setBool(String chave, bool value) async {
    var storage = await SharedPreferences.getInstance();
    storage.setBool(chave, value);
  }

  Future<bool> _getBool(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getBool(chave) ?? false;
  }
}
