
class GQLQuery {
  static String getProjects = '''
  query GetProjects {
    queryProject {
      description
      flavors
      id
      teams
      title
      image_url
    }
  }
  ''';

  static String getTickets = '''
  query Tickets {
    queryTicket {
      title
      ticket_type
      status
      priority
      project
      occurrence_module
      occurrence_element
      improvement
      id
      flavor
      device_model
      device
      description
      created_by 
      assigned_to 
    }
  }
  ''';
}


