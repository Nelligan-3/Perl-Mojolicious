#!C:\Strawberry\perl\bin\perl.exe
package AccountObject;

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
    if (defined($FORM{hidId})) {
      my $aid = $FORM{hidId};
    } elsif (defined($FORM{hidNewId})) {
      my $aid = $FORM{hidNewId};
    } else {
      my $aid = 0;
    }
    if (defined($FORM{txtAccountname})) {
      $aname = $FORM{txtAccountname};
    } elsif (defined($FORM{txtNewAccountname})) {
      $aname = $FORM{txtNewAccountname};
    } else {
      $aname = "";
    }
    if (defined($FORM{txtPassword})) {
      $password = $FORM{txtPassword};
    } elsif (defined($FORM{txtNewPassword})) {
      $password = $FORM{txtNewPassword};
    } else {
      $password = "";
    }
    if (defined($FORM{txtFirstname})) {
      $fname = $FORM{txtFirstname};
    } elsif (defined($FORM{txtNewFirstname})) {
      $fname = $FORM{txtNewFirstname};
    } else {
      $fname = "";
    }
    if (defined($FORM{txtLastname})) {
      $lname = $FORM{txtLastname};
    } elsif (defined($FORM{txtNewLastname})) {
      $lname = $FORM{txtNewLastname};
    } else {
      $lname = "";
    }
    if (defined($FORM{hidLang})) {
	  $lang = $FORM{hidLang};
    } elsif (defined($FORM{hidNewLang})) {
	  $lang = $FORM{hidNewLang};
    } else {
	  $lang = "en";
    }
    if (defined($FORM{hidSid})) {
      $sid = $FORM{hidSid};
    } else {
      $sid = 0;
    }
	if (defined($FORM{hidAction})) {
	  $action = $FORM{hidAction};
    } else {
	  $action = "index";
    }
    my $self = {
	  _action => $action,
	  _lang => $lang,
      _sid => $sid,
      _id => $aid,
      _accountname => $aname,
	  _password => $password,
      _firstname => $fname,
      _lastname => $lname,
    };
    return bless $self, $class;
  } else {
    my $self = {
	  _action => "index",
	  _lang => "en",
      _sid => 0,
      _id => $row[0],
      _accountname => $row[1],
	  _password => $row[2],
      _firstname => $row[3],
      _lastname => $row[4],
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

sub getLang {
    my ($self) = @_;
    return $self->{_lang};
}

sub setLang {
    my ($self, $lang) = @_;
    $self->{_lang} = $lang if defined($lang);
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

sub getAccountname {
    my ($self) = @_;
    return $self->{_accountname};
}

sub setAccountname {
    my ($self, $accountname) = @_;
    $self->{_accountname} = $accountname if defined($accountname);
}

sub getPassword {
    my ($self) = @_;
    return $self->{_password};
}

sub setPassword {
    my ($self, $password) = @_;
    $self->{_password} = $password if defined($password);
}

sub getFirstname {
    my ($self) = @_;
    return $self->{_firstname};
}

sub setFirstname {
    my ($self, $firstname) = @_;
    $self->{_firstname} = $firstname if defined($firstname);
}

sub getLastname {
    my ($self) = @_;
    return $self->{_lastname};
}

sub setLastname {
    my ($self, $lastname) = @_;
    $self->{_lastname} = $lastname if defined($lastname);
}
1;