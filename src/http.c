#define EPOLL
#define HTTPSERVER_IMPL
#include "httpserver.h"
#include <sys/stat.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <unistd.h>

void handle_request(struct http_request_s* request) {
  struct http_response_s* response = http_response_init();
  http_request_connection(request, HTTP_CLOSE);
  http_response_header(response, "Content-Type", "application/octet-stream");
  http_response_status(response, STATUS_CODE);
  http_respond(request, response);
}

struct http_server_s* server;

void handle_sigterm(int signum) {
  free(server);
  exit(0);
}

int main() {
int port;
  port=8000;
  server = http_server_init(port, handle_request);
  signal(SIGTERM, handle_sigterm);
  signal(SIGINT, handle_sigterm);
  http_server_listen(server);
  return 1;
}
