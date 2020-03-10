part of './offline_database.dart';

@DataClassName("ChannelQuery")
class _ChannelQueries extends Table {
  TextColumn get queryHash => text()();
  TextColumn get channelCid => text()();

  @override
  Set<Column> get primaryKey => {
        queryHash,
        channelCid,
      };
}

class _Channels extends Table {
  TextColumn get id => text()();

  TextColumn get type => text()();

  TextColumn get cid => text()();

  BoolColumn get frozen => boolean().withDefault(Constant(false))();

  DateTimeColumn get lastMessageAt => dateTime().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();

  DateTimeColumn get deletedAt => dateTime().nullable()();

  IntColumn get memberCount => integer().nullable()();

  TextColumn get extraData => text().nullable().map(_ExtraDataConverter())();

  TextColumn get createdBy => text().nullable()();

  @override
  Set<Column> get primaryKey => {cid};
}

class _Users extends Table {
  TextColumn get id => text()();

  TextColumn get role => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime().nullable()();

  DateTimeColumn get lastActive => dateTime().nullable()();

  BoolColumn get online => boolean().nullable()();

  BoolColumn get banned => boolean().nullable()();

  TextColumn get extraData => text().nullable().map(_ExtraDataConverter())();

  @override
  Set<Column> get primaryKey => {id};
}

class _Reads extends Table {
  DateTimeColumn get lastRead => dateTime()();

  TextColumn get userId => text()();

  TextColumn get channelCid => text()();

  @override
  Set<Column> get primaryKey => {
        userId,
        channelCid,
      };
}

class _Messages extends Table {
  TextColumn get id => text()();

  TextColumn get messageText => text().nullable()();

  IntColumn get status =>
      integer().map(_MessageSendingStatusConverter()).nullable()();

  TextColumn get type => text().nullable()();

  List<User> mentionedUsers;

  TextColumn get reactionCounts =>
      text().nullable().map(_ExtraDataConverter<int>())();

  TextColumn get reactionScores =>
      text().nullable().map(_ExtraDataConverter<int>())();

//  List<Reaction> latestReactions;
//  List<Reaction> ownReactions;
  TextColumn get parentId => text().nullable()();

  IntColumn get replyCount => integer().nullable()();

  BoolColumn get showInChannel => boolean().nullable()();

  TextColumn get command => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime().nullable()();

  TextColumn get userId => text().nullable()();

  TextColumn get channelCid => text().nullable()();

  TextColumn get extraData => text().nullable().map(_ExtraDataConverter())();

  @override
  Set<Column> get primaryKey => {id};
}

class _Members extends Table {
  TextColumn get userId => text()();

  TextColumn get channelCid => text()();

  TextColumn get role => text().nullable()();

  DateTimeColumn get inviteAcceptedAt => dateTime().nullable()();

  DateTimeColumn get inviteRejectedAt => dateTime().nullable()();

  BoolColumn get invited => boolean().nullable()();

  BoolColumn get isModerator => boolean().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {
        userId,
        channelCid,
      };
}

class _Attachments extends Table {
  TextColumn get messageId => text()();

  TextColumn get type => text().withDefault(Constant(''))();

  TextColumn get titleLink => text().withDefault(Constant(''))();

  TextColumn get title => text().nullable()();

  TextColumn get thumbUrl => text().withDefault(Constant(''))();

  TextColumn get attachmentText => text().nullable()();

  TextColumn get pretext => text().nullable()();

  TextColumn get ogScrapeUrl => text().nullable()();

  TextColumn get imageUrl => text().withDefault(Constant(''))();

  TextColumn get footerIcon => text().nullable()();

  TextColumn get footer => text().nullable()();

  TextColumn get fallback => text().nullable()();

  TextColumn get color => text().nullable()();

  TextColumn get authorName => text().nullable()();

  TextColumn get authorLink => text().nullable()();

  TextColumn get authorIcon => text().nullable()();

  TextColumn get assetUrl => text().withDefault(Constant(''))();

  TextColumn get extraData => text().nullable().map(_ExtraDataConverter())();

  @override
  Set<Column> get primaryKey => {
        messageId,
        imageUrl,
        assetUrl,
        type,
        thumbUrl,
        titleLink,
      };
}

class _ExtraDataConverter<T> extends TypeConverter<Map<String, T>, String> {
  @override
  Map<String, T> mapToDart(fromDb) {
    if (fromDb == null) {
      return null;
    }
    return Map<String, T>.from(jsonDecode(fromDb) ?? {});
  }

  @override
  String mapToSql(value) {
    return jsonEncode(value);
  }
}

class _MessageSendingStatusConverter
    extends TypeConverter<MessageSendingStatus, int> {
  @override
  MessageSendingStatus mapToDart(int fromDb) {
    switch (fromDb) {
      case 0:
        return MessageSendingStatus.SENDING;
      case 1:
        return MessageSendingStatus.SENT;
      case 2:
        return MessageSendingStatus.FAILED;
      default:
        return null;
    }
  }

  @override
  int mapToSql(MessageSendingStatus value) {
    switch (value) {
      case MessageSendingStatus.SENDING:
        return 0;
      case MessageSendingStatus.SENT:
        return 1;
      case MessageSendingStatus.FAILED:
        return 2;
      default:
        return null;
    }
  }
}
