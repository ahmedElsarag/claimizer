class ReloadHomeEvent {
  bool isRefresh;

  bool isFirst = false, isSecond = false;

  ReloadHomeEvent(
      {this.isRefresh, this.isFirst = false, this.isSecond = false});
}
