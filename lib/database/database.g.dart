// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorEsoDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$EsoDatabaseBuilder databaseBuilder(String name) =>
      _$EsoDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$EsoDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$EsoDatabaseBuilder(null);
}

class _$EsoDatabaseBuilder {
  _$EsoDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$EsoDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$EsoDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<EsoDatabase> build() async {
    final database = _$EsoDatabase();
    database.database = await database.open(
      name ?? ':memory:',
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$EsoDatabase extends EsoDatabase {
  _$EsoDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  RuleDao _ruleDaoInstance;

  Future<sqflite.Database> open(String name, List<Migration> migrations,
      [Callback callback]) async {
    final path = join(await sqflite.getDatabasesPath(), name);

    return sqflite.openDatabase(
      path,
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Rule` (`id` INTEGER, `enable` INTEGER, `name` TEXT, `host` TEXT, `contentType` TEXT, `enCheerio` INTEGER, `discoverUrl` TEXT, `discoverItems` TEXT, `searchUrl` TEXT, `searchItems` TEXT, `detailUrl` TEXT, `detailItems` TEXT, `enMultiRoads` INTEGER, `chapterUrl` TEXT, `chapterItems` TEXT, `contentUrl` TEXT, `contentItems` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
  }

  @override
  RuleDao get ruleDao {
    return _ruleDaoInstance ??= _$RuleDao(database, changeListener);
  }
}

class _$RuleDao extends RuleDao {
  _$RuleDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _ruleInsertionAdapter = InsertionAdapter(
            database,
            'Rule',
            (Rule item) => <String, dynamic>{
                  'id': item.id,
                  'enable': item.enable ? 1 : 0,
                  'name': item.name,
                  'host': item.host,
                  'contentType': item.contentType,
                  'enCheerio': item.enCheerio ? 1 : 0,
                  'discoverUrl': item.discoverUrl,
                  'discoverItems': item.discoverItems,
                  'searchUrl': item.searchUrl,
                  'searchItems': item.searchItems,
                  'detailUrl': item.detailUrl,
                  'detailItems': item.detailItems,
                  'enMultiRoads': item.enMultiRoads ? 1 : 0,
                  'chapterUrl': item.chapterUrl,
                  'chapterItems': item.chapterItems,
                  'contentUrl': item.contentUrl,
                  'contentItems': item.contentItems
                },
            changeListener),
        _ruleUpdateAdapter = UpdateAdapter(
            database,
            'Rule',
            ['id'],
            (Rule item) => <String, dynamic>{
                  'id': item.id,
                  'enable': item.enable ? 1 : 0,
                  'name': item.name,
                  'host': item.host,
                  'contentType': item.contentType,
                  'enCheerio': item.enCheerio ? 1 : 0,
                  'discoverUrl': item.discoverUrl,
                  'discoverItems': item.discoverItems,
                  'searchUrl': item.searchUrl,
                  'searchItems': item.searchItems,
                  'detailUrl': item.detailUrl,
                  'detailItems': item.detailItems,
                  'enMultiRoads': item.enMultiRoads ? 1 : 0,
                  'chapterUrl': item.chapterUrl,
                  'chapterItems': item.chapterItems,
                  'contentUrl': item.contentUrl,
                  'contentItems': item.contentItems
                },
            changeListener),
        _ruleDeletionAdapter = DeletionAdapter(
            database,
            'Rule',
            ['id'],
            (Rule item) => <String, dynamic>{
                  'id': item.id,
                  'enable': item.enable ? 1 : 0,
                  'name': item.name,
                  'host': item.host,
                  'contentType': item.contentType,
                  'enCheerio': item.enCheerio ? 1 : 0,
                  'discoverUrl': item.discoverUrl,
                  'discoverItems': item.discoverItems,
                  'searchUrl': item.searchUrl,
                  'searchItems': item.searchItems,
                  'detailUrl': item.detailUrl,
                  'detailItems': item.detailItems,
                  'enMultiRoads': item.enMultiRoads ? 1 : 0,
                  'chapterUrl': item.chapterUrl,
                  'chapterItems': item.chapterItems,
                  'contentUrl': item.contentUrl,
                  'contentItems': item.contentItems
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _ruleMapper = (Map<String, dynamic> row) => Rule(
      row['id'] as int,
      (row['enable'] as int) != 0,
      row['name'] as String,
      row['host'] as String,
      row['contentType'] as String,
      (row['enCheerio'] as int) != 0,
      row['discoverUrl'] as String,
      row['discoverItems'] as String,
      row['searchUrl'] as String,
      row['searchItems'] as String,
      row['detailUrl'] as String,
      row['detailItems'] as String,
      (row['enMultiRoads'] as int) != 0,
      row['chapterUrl'] as String,
      row['chapterItems'] as String,
      row['contentUrl'] as String,
      row['contentItems'] as String);

  final InsertionAdapter<Rule> _ruleInsertionAdapter;

  final UpdateAdapter<Rule> _ruleUpdateAdapter;

  final DeletionAdapter<Rule> _ruleDeletionAdapter;

  @override
  Future<Rule> findRuleById(int id) async {
    return _queryAdapter.query('SELECT * FROM rule WHERE id = ?',
        arguments: <dynamic>[id], mapper: _ruleMapper);
  }

  @override
  Future<List<Rule>> findAllRules() async {
    return _queryAdapter.queryList('SELECT * FROM rule', mapper: _ruleMapper);
  }

  @override
  Stream<List<Rule>> findAllRulesAsStream() {
    return _queryAdapter.queryListStream('SELECT * FROM rule',
        tableName: 'Rule', mapper: _ruleMapper);
  }

  @override
  Future<void> deleteRuleById(int id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM rule WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<void> insertRule(Rule rule) async {
    await _ruleInsertionAdapter.insert(rule, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<void> insertRules(List<Rule> rules) async {
    await _ruleInsertionAdapter.insertList(
        rules, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<void> insertOrUpdateRule(Rule rule) async {
    await _ruleInsertionAdapter.insert(rule, sqflite.ConflictAlgorithm.replace);
  }

  @override
  Future<void> insertOrUpdateRules(List<Rule> rules) async {
    await _ruleInsertionAdapter.insertList(
        rules, sqflite.ConflictAlgorithm.replace);
  }

  @override
  Future<void> updateRule(Rule rule) async {
    await _ruleUpdateAdapter.update(rule, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<void> updateRules(List<Rule> rule) async {
    await _ruleUpdateAdapter.updateList(rule, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<void> deleteRule(Rule rule) async {
    await _ruleDeletionAdapter.delete(rule);
  }

  @override
  Future<void> deleteRules(List<Rule> rules) async {
    await _ruleDeletionAdapter.deleteList(rules);
  }
}
