
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
}