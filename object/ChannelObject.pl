#!C:\Strawberry\perl\bin\perl.exe
package ChannelObject;

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
    if (defined($FORM{hidSid})) {
      $sid = $FORM{hidSid};
    } else {
      $sid = 0;
    }
    if (defined($FORM{hidId})) {
      $cid = $FORM{hidId};
    } else {
      $cid = 0;
    }
    if (defined($FORM{hidAccountId})) {
      $aid = $FORM{hidAccountId};
    } else {
      $aid = 0;
    }
    if (defined($FORM{txtName})) {
      $cname = $FORM{txtName};
    } else {
      $cname = "";
    }
    if (defined($FORM{hidLang})) {
      $lang = $FORM{hidLang};
    } else {
      $lang = "en";
    }
    my $self = {
	  _action => $action,
      _sid => $sid,
      _id => $cid,
      _account_id => $aid,
      _name => $cname,
	  _lang => $lang,
    };
    bless $self, $class;
    return $self;
  } else {
    my $self = {
	  _action => "index",
      _sid => 0,
      _id => $row[0],
      _account_id => $row[1],
      _name => $row[2],
	  _lang => $row[3],
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

sub getName {
    my ($self) = @_;
    return $self->{_name};
}

sub setName {
    my ($self, $name) = @_;
    $self->{_name} = $name if defined($name);
}

sub getLang {
    my ($self) = @_;
    return $self->{_lang};
}

sub setLang {
    my ($self, $lang) = @_;
    $self->{_lang} = $lang if defined($lang);
}
1;