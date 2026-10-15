#!C:\Strawberry\perl\bin\perl.exe
package ErrorTextObject;

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
      my $id = $FORM{hidId};
    } elsif (defined($FORM{hidNewId})) {
      my $id = $FORM{hidNewId};
    } else {
      my $id = 0;
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
    if (defined($FORM{hidLang})) {
	  $lang = $FORM{hidLang};
    } else {
	  $lang = "en";
    }
    if (defined($FORM{hidErrortext_id})) {
      $eid = $FORM{hidErrortext_id};
    } else {
      $eid = 0;
    }
    if (defined($FORM{lblErrortext})) {
	  $errortext = $FORM{lblErrortext};
    } else {
	  $errortext = "";
    }
    my $self = {
	  _action => "get",
      _sid => $sid,
      _id => $id,
      _errortext_id => $eid,
	  _lang => $lang,
      _errortext => $errortext,
    };
    return bless $self, $class;
  } else {
    my $self = {
	  _action => "get",
      _sid => 0,
      _id => $row[0],
      _errortext_id => $row[1],
	  _lang => $row[2],
      _errortext => $row[3],
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

sub getErrortext_Id {
    my ($self) = @_;
    return $self->{_errortext_id};
}

sub setErrortext_Id {
    my ($self, $errortext_id) = @_;
    $self->{_errortext_id} = $errortext_id if defined($errortext_id);
}

sub getLang {
    my ($self) = @_;
    return $self->{_lang};
}

sub setLang {
    my ($self, $lang) = @_;
    $self->{_lang} = $lang if defined($lang);
}

sub getErrortext {
    my ($self) = @_;
    return $self->{_errortext};
}

sub setErrortext {
    my ($self, $errortext) = @_;
    $self->{_errortext} = $errortext if defined($errortext);
}
1;