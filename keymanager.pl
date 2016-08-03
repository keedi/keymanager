#!/usr/bin/env perl

use Mojolicious::Lite;

=head2 GET /

전체 기능 링크를 보여줍니다.

=cut

get "/" => sub {
    my $c = shift;
    $c->render( template => "index" );
};

=head2 GET /login

로그인을 수행합니다.

=cut

get "/login" => sub {
    my $c = shift;
    $c->render( template => "login" );
};

=head2 GET /logout

로그아웃을 수행합니다.

=cut

get "/logout" => sub {
    my $c = shift;
    $c->render( template => "logout" );
};

=head2 GET /key/delete

지울 호스트를 입력하기 위한 화면입니다.

=cut

get "/key/delete" => sub {
    my $c = shift;
    $c->render( template => "key-delete" );
};

=head2 GET /host/:host/key/delete

해당 호스트의 키를 삭제하도록 서버에 요청합니다.

=cut

get "/host/:host/key/delete" => sub {
    my $c    = shift;
    my $host = $c->stash("host");

    $c->render(
        template => "host-name-key-delete",
        host     => $host,
    );
};

=head2 GET /user/:user/history

해당 사용자가 요청한 내역을 열람합니다.
이 화면은 해당 사용자나 관리자만이 열람할 수 있습니다.

=cut

get "/user/:user/history" => sub {
    my $c    = shift;
    my $user = $c->stash("user");

    $c->render(
        template => "user-name-history",
        user     => $user,
    );
};

=head2 GET /history

모든 사용자가 요청한 내역을 열람합니다.
이 화면은 관리자만이 열람할 수 있습니다.

=cut

get "/history" => sub {
    my $c = shift;
    $c->render( template => "history" );
};

app->start;

__DATA__

@@ layouts/default.html.ep
<!DOCTYPE html>
<html>
  <head><title><%= title %></title></head>
  <body>
    %= link_to "첫 화면" =>  "/";
    <%= content %>
  </body>
</html>

@@ index.html.ep
% layout "default";
% title "Home";
<h1>첫 화면</h1>

%= tag "ul" => begin
  <%= tag "li" => begin %> <%= link_to "login"                =>  "/login" %>                <% end %>
  <%= tag "li" => begin %> <%= link_to "logout"               =>  "/logout" %>               <% end %>
  <%= tag "li" => begin %> <%= link_to "key-delete"           =>  "/key/delete" %>           <% end %>
  <%= tag "li" => begin %> <%= link_to "host-fiaa-key-delete" =>  "/host/fiaa/key/delete" %> <% end %>
  <%= tag "li" => begin %> <%= link_to "user-aqua-history"    =>  "/user/aqua/history" %>    <% end %>
  <%= tag "li" => begin %> <%= link_to "history"              =>  "/history" %>              <% end %>
% end

@@ login.html.ep
% layout "default";
% title "Login";
<h1>로그인 화면</h1>

@@ logout.html.ep
% layout "default";
% title "Logout";
<h1>로그아웃 화면</h1>

@@ key-delete.html.ep
% layout "default";
% title "Key Delete";
<h1>키 제거 화면</h1>

@@ host-name-key-delete.html.ep
% layout "default";
% title "Host Name Key Delete";
<h1><%= $host %> 호스트 키 제거 화면</h1>

@@ user-name-history.html.ep
% layout "default";
% title "User Name History";
<h1><%= $user %> 사용자 히스토리</h1>

@@ history.html.ep
% layout "default";
% title "History";
<h1>전체 히스토리</h1>
