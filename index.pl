#!C:\Strawberry\perl\bin\perl.exe
use Mojolicious::Lite -signatures;
require './action/ErrorTextAction.pl';
require './action/LabelTextAction.pl';
require './action/AccountAction.pl';
require './action/ChannelAction.pl';
require './action/MessageAction.pl';

get "/" => sub ($c) {
  my $lang = "en";
  if(defined($c->param("rdbLang"))){
	$lang = $c->param("rdbLang");
  }
  $c->render(template => "index", lang => $lang);
};

post "/newaccount" => sub ($c) {
  my $lang = "en";
  if(defined($c->param("hidNewLang"))){
	$lang = $c->param("hidNewLang");
  }
  my $action = AccountAction->new;
  my $act = $action->doInsert($c->param("hidId"), $c->param("txtNewAccountname"), $c->param("txtNewPassword"), $c->param("txtNewFirstname"), $c->param("txtNewLastname"));
  my $eaction = ErrorTextAction->new;
  my %jsonErrortexts = $eaction->doGet($act, $lang);
  $c->render(template => "return", lang => $lang, errortext => $jsonErrortexts{$act});
};

post "/login" => sub ($c) {
  my $lang = "en";
  if(defined($c->param("hidLang"))){
	$lang = $c->param("hidLang");
  }
  my $action = AccountAction->new;
  my $act = $action->doLogin($c->param("txtAccountname"), $c->param("txtPassword"));
  if($act == 0){
    my $action = ErrorTextAction->new;
    my %jsonErrortexts = $action->doGet(1, $lang);
    $c->render(template => "return", lang => $lang, errortext => $jsonErrortexts{1});
  } else {
    $c->session->{"lang"} = $lang;
    $c->session->{"accountId"} = $act;
    $c->render(template => "channels", lang => $lang, accountid => $act);
  }
};

get "/logout" => sub ($c) {
  my $lang = "en";
  if(defined($c->session->{"lang"})){
	$lang = $c->session->{"lang"};
  }
  if(defined($c->session->{"accountId"})){
	$c->session->{"accountId"} = 0;
  }
  my $action = ErrorTextAction->new;
  my %jsonErrortexts = $action->doGet(4, $lang);
  $c->render(template => "return", lang => $lang, errortext => $jsonErrortexts{4});
};

get "/getLabelTexts" => sub ($c) {
  my $action = LabelTextAction->new;
  my %jsonLabelTexts = $action->doGet($c->param("hidPage"), $c->param("rdbLang"));
  $c->render(json => \%jsonLabelTexts);
};

get "/channels" => sub ($c) {
  my $lang = "en";
  my $accountId = 0;
  if(defined($c->param("hidLang"))){
	$lang = $c->param("hidLang");
  } elsif(defined($c->session->{"lang"})){
	$lang = $c->session->{"lang"};
  }
  if(defined($c->session->{"accountId"})){
	$accountId = $c->session->{"accountId"};
  }
  $c->render(template => "channels", lang => $lang, accountid => $accountId);
};

get "/getChannels" => sub ($c) {
  my $lang = "en";
  if(defined($c->param("hidLang"))){
	$lang = $c->param("hidLang");
  } elsif(defined($c->session->{"lang"})){
	$lang = $c->session->{"lang"};
  }
  my $action = ChannelAction->new;
  my %jsonChannels = $action->doGet($lang);
  $c->render(json => \%jsonChannels);
};

post "/newchannel" => sub ($c) {
  my $lang = "en";
  if(defined($c->param("hidLang"))){
	$lang = $c->param("hidLang");
  }
  my $action = ChannelAction->new;
  $action->doInsert($c->param("hidId"), $c->param("hidAccountId"), $c->param("txtName"), $lang);
  $c->render(template => "channels", lang => $lang, accountid => $c->param("hidAccountId"));
};

get  "/messages" => sub ($c) {
  my $lang = "en";
  my $accountId = 0;
  my $channelId = 0;
  if(defined($c->session->{"lang"})){
    $lang = $c->session->{"lang"};
  }
  if(defined($c->session->{"accountId"})){
    $accountId = $c->session->{"accountId"};
  }
  if(defined($c->req->param("hidChannelId"))){
    $channelId = $c->req->param("hidChannelId");
  }
  $c->render(template => "messages", lang => $lang, accountid => $accountId, channelid => $channelId);
};

get "/getMessages" => sub ($c) {
  my $action = MessageAction->new;
  my %jsonMessages = $action->doGet($c->param("hidChannelId"));
  $c->render(json => \%jsonMessages);
};

post "/newmessage" => sub ($c) {
  my $lang = "en";
  if(defined($c->param("hidLang"))){
	$lang = $c->param("hidLang");
  }
  my $action = MessageAction->new;
  $action->doInsert($c->param("hidId"), $c->param("hidAccountId"), $c->param("hidChannelId"), $c->param("txtMessage"));
  $c->render(template => "messages", lang => $lang, accountid => $c->param("hidAccountId"), channelid => $c->param("hidChannelId"));
};

app->start;