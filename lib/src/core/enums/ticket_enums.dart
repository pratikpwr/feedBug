import '../constants/assets_constants.dart';

enum TicketType {
  bug,
  improvement,
  feedback;

  static TicketType? fromString(String? str) {
    switch (str) {
      case 'bug':
        return TicketType.bug;
      case 'improvement':
        return TicketType.improvement;
      case 'feedback':
        return TicketType.feedback;
      default:
        return null;
    }
  }

  String get toKey {
    switch (this) {
      case TicketType.bug:
        return 'bug';
      case TicketType.improvement:
        return 'improvement';
      case TicketType.feedback:
        return 'feedback';
    }
  }

  String get icon {
    switch (this) {
      case TicketType.bug:
        return Assets.bug;
      case TicketType.improvement:
        return Assets.improvement;
      case TicketType.feedback:
        return Assets.feedback;
    }
  }
}

enum TicketPriority {
  highest,
  high,
  medium,
  low,
  lowest;

  static TicketPriority? fromKey(String? str) {
    switch (str) {
      case 'highest':
        return TicketPriority.highest;
      case 'high':
        return TicketPriority.high;
      case 'medium':
        return TicketPriority.medium;
      case 'low':
        return TicketPriority.low;
      case 'lowest':
        return TicketPriority.lowest;
      default:
        return null;
    }
  }

  String get toKey {
    switch (this) {
      case TicketPriority.highest:
        return 'highest';
      case TicketPriority.high:
        return 'high';
      case TicketPriority.medium:
        return 'medium';
      case TicketPriority.low:
        return 'low';
      case TicketPriority.lowest:
        return 'lowest';
    }
  }

  String get iconPath {
    switch (this) {
      case TicketPriority.highest:
        return Assets.priorityHighest;
      case TicketPriority.high:
        return Assets.priorityHigh;
      case TicketPriority.medium:
        return Assets.priorityMedium;
      case TicketPriority.low:
        return Assets.priorityLow;
      case TicketPriority.lowest:
        return Assets.priorityLowest;
    }
  }
}

enum TicketStatus {
  created,
  willDo,
  notDoing,
  inProgress,
  nextTime,
  done;

  static TicketStatus? fromKey(String? str) {
    switch (str) {
      case 'created':
        return TicketStatus.created;
      case 'willDo':
        return TicketStatus.willDo;
      case 'notDoing':
        return TicketStatus.notDoing;
      case 'inProgress':
        return TicketStatus.inProgress;
      case 'nextTime':
        return TicketStatus.nextTime;
      case 'done':
        return TicketStatus.done;
      default:
        return null;
    }
  }

  String get toKey {
    switch (this) {
      case TicketStatus.created:
        return 'created';
      case TicketStatus.willDo:
        return 'willDo';
      case TicketStatus.notDoing:
        return 'notDoing';
      case TicketStatus.inProgress:
        return 'inProgress';
      case TicketStatus.nextTime:
        return 'nextTime';
      case TicketStatus.done:
        return 'done';
    }
  }
}
