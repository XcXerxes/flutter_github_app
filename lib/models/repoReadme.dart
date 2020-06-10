class RepoReadme {
  String _name;
  String _path;
  String _sha;
  int _size;
  String _url;
  String _htmlUrl;
  String _gitUrl;
  String _downloadUrl;
  String _type;
  String _content;
  String _encoding;
  Links _lLinks;

  RepoReadme(
      {String name,
      String path,
      String sha,
      int size,
      String url,
      String htmlUrl,
      String gitUrl,
      String downloadUrl,
      String type,
      String content,
      String encoding,
      Links lLinks}) {
    this._name = name;
    this._path = path;
    this._sha = sha;
    this._size = size;
    this._url = url;
    this._htmlUrl = htmlUrl;
    this._gitUrl = gitUrl;
    this._downloadUrl = downloadUrl;
    this._type = type;
    this._content = content;
    this._encoding = encoding;
    this._lLinks = lLinks;
  }

  String get name => _name;
  set name(String name) => _name = name;
  String get path => _path;
  set path(String path) => _path = path;
  String get sha => _sha;
  set sha(String sha) => _sha = sha;
  int get size => _size;
  set size(int size) => _size = size;
  String get url => _url;
  set url(String url) => _url = url;
  String get htmlUrl => _htmlUrl;
  set htmlUrl(String htmlUrl) => _htmlUrl = htmlUrl;
  String get gitUrl => _gitUrl;
  set gitUrl(String gitUrl) => _gitUrl = gitUrl;
  String get downloadUrl => _downloadUrl;
  set downloadUrl(String downloadUrl) => _downloadUrl = downloadUrl;
  String get type => _type;
  set type(String type) => _type = type;
  String get content => _content;
  set content(String content) => _content = content;
  String get encoding => _encoding;
  set encoding(String encoding) => _encoding = encoding;
  Links get lLinks => _lLinks;
  set lLinks(Links lLinks) => _lLinks = lLinks;

  RepoReadme.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _path = json['path'];
    _sha = json['sha'];
    _size = json['size'];
    _url = json['url'];
    _htmlUrl = json['html_url'];
    _gitUrl = json['git_url'];
    _downloadUrl = json['download_url'];
    _type = json['type'];
    _content = json['content'];
    _encoding = json['encoding'];
    _lLinks =
        json['_links'] != null ? new Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    data['path'] = this._path;
    data['sha'] = this._sha;
    data['size'] = this._size;
    data['url'] = this._url;
    data['html_url'] = this._htmlUrl;
    data['git_url'] = this._gitUrl;
    data['download_url'] = this._downloadUrl;
    data['type'] = this._type;
    data['content'] = this._content;
    data['encoding'] = this._encoding;
    if (this._lLinks != null) {
      data['_links'] = this._lLinks.toJson();
    }
    return data;
  }
}

class Links {
  String _self;
  String _git;
  String _html;

  Links({String self, String git, String html}) {
    this._self = self;
    this._git = git;
    this._html = html;
  }

  String get self => _self;
  set self(String self) => _self = self;
  String get git => _git;
  set git(String git) => _git = git;
  String get html => _html;
  set html(String html) => _html = html;

  Links.fromJson(Map<String, dynamic> json) {
    _self = json['self'];
    _git = json['git'];
    _html = json['html'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['self'] = this._self;
    data['git'] = this._git;
    data['html'] = this._html;
    return data;
  }
}
