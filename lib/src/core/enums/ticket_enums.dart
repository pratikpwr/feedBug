import '../constants/assets_constants.dart';

enum TicketType {
  bug,
  improvement,
  feedback;

  static TicketType fromString(String str) {
    switch (str) {
      case 'bug':
        return TicketType.bug;
      case 'improvement':
        return TicketType.improvement;
      case 'feedback':
        return TicketType.feedback;
      default:
        throw Exception('Unknown TicketType: $str');
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
      default:
        throw Exception('Unknown TicketType: $this');
    }
  }
}

enum TicketPriority {
  highest,
  high,
  medium,
  low,
  lowest;

  static TicketPriority fromString(String str) {
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
        throw Exception('Unknown TicketPriority: $str');
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

  static TicketStatus fromString(String str) {
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
        throw Exception('Unknown TicketStatus: $str');
    }
  }
}
