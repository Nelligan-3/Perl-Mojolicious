#!C:\Strawberry\perl\bin\perl.exe
package MessageObject;

sub new {
  my ($class, @row) = @_;
  if(@row == 0){
    local ($buffer, @pairs, $pair, $name, $value, %FORM);
    $ENV{'REQUEST_METHOD'} =~ tr/a-z/A-Z/;
    if ($ENV{'REQUEST_METHOD'} eq "POST") {
      read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'});
    } else {
      $buffer = $ENV{'QUERY_STRING'};
    }
    @pairs = split(/&/, $buffer);
    foreach $pair (@pairs) {
      ($name, $value) = split(/=/, $pair);
      $value =~ tr/+/ /;
      $value =~ s/%(..)/pack("C", hex($1))/eg;
      $FORM{$name} = $value;
    }
	if (defined($FORM{hidAction})) {
	  $action = $FORM{hidAction};
    } else {
	  $action = "index";
    }
    if (defined($FORM{hidLang})) {
      $lang = $FORM{hidLang};
    } else {
      $lang = "en";
    }
    if (defined($FORM{hidSid})) {
      $sid = $FORM{hidSid};
    } else {
      $sid = 0;
    }
    if (defined($FORM{hidId})) {
      $mid = $FORM{hidId};
    } else {
      $mid = 0;
    }
    if (defined($FORM{hidAccountId})) {
      $aid = $FORM{hidAccountId};
    } else {
      $aid = 0;
    }
    if (defined($FORM{hidChannelId})) {
      $cid = $FORM{hidChannelId};
    } else {
      $cid = 0;
    }
    if (defined($FORM{txtMessage})) {
      $message = $FORM{txtMessage};
    } else {
      $message = "";
    }
    my $self = {
	  _action => $action,
	  _lang => $lang,
      _sid => $sid,
      _id => $mid,
      _account_id => $aid,
	  _channel_id => $cid,
      _message => $message,
      _creationdate => undef,
    };
    bless $self, $class;
    return $self;
  } else {
    my $self = {
	  _action => "index",
	  _lang => "en",
      _sid => 0,
      _id => $row[0],
      _account_id => $row[1],
	  _channel_id => $row[2],
      _message => $row[3],
      _creationdate => $row[4],
    };
    return bless $self, $class;
  }
}

sub getAction {
    my ($self) = @_;
    return $self->{_action};
}

sub setAction {
    my ($self, $action) = @_;
    $self->{_lang} = $action if defined($action);
}

sub getSid {
    my ($self) = @_;
    return $self->{_sid};
}

sub setSid {
    my ($self, $sid) = @_;
    $self->{_sid} = $sid if defined($sid);
}

sub getId {
    my ($self) = @_;
    return $self->{_id};
}

sub setId {
    my ($self, $id) = @_;
    $self->{_id} = $id if defined($id);
}

sub getAccount_Id {
    my ($self) = @_;
    return $self->{_account_id};
}

sub setAccount_Id {
    my ($self, $account_id) = @_;
    $self->{_account_id} = $account_id if defined($account_id);
}

sub getChannel_Id {
    my ($self) = @_;
    return $self->{_channel_id};
}

sub setChannel_Id {
    my ($self, $channel_id) = @_;
    $self->{_channel_id} = $channel_id if defined($channel_id);
}

sub getMessage {
    my ($self) = @_;
    return $self->{_message};
}

sub setMessage {
    my ($self, $message) = @_;
    $self->{_message} = $message if defined($message);
}

sub getCreationdate {
    my ($self) = @_;
    return $self->{_creationdate};
}

sub setCreationdate {
    my ($self, $creationdate) = @_;
    $self->{_creationdate} = $creationdate if defined($creationdate);
}
1;