#!C:\Strawberry\perl\bin\perl.exe
package LabelTextObject;

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
      my $tid = $FORM{hidId};
    } elsif (defined($FORM{hidNewId})) {
      my $tid = $FORM{hidNewId};
    } else {
      my $tid = 0;
    }
	if (defined($FORM{hidAction})) {
	  $action = $FORM{hidAction};
    } else {
	  $action = "index";
    }
    if (defined($FORM{rdbLang})) {
	  $lang = $FORM{rdbLang};
    } elsif (defined($FORM{hidLang})) {
	  $lang = $FORM{hidLang};
    } else {
	  $lang = "en";
    }
    if (defined($FORM{hidPage})) {
	  $page = $FORM{hidPage};
    } else {
	  $page = "index";
    }
    if (defined($FORM{hidPosition})) {
	  $position = $FORM{hidPosition};
    } else {
	  $position = "";
    }
    if (defined($FORM{lblLabeltext})) {
	  $labeltext = $FORM{lblLabeltext};
    } else {
	  $labeltext = "";
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
      _sid => $sid,
      _id => $tid,
      _page => $page,
	  _lang => $lang,
      _position => $position,
      _labeltext => $labeltext,
    };
    return bless $self, $class;
  } else {
    my $self = {
	  _action => "index",
      _sid => 0,
      _id => $row[0],
      _page => $row[1],
	  _lang => $row[2],
      _position => $row[3],
      _labeltext => $row[4],
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

sub getPage {
    my ($self) = @_;
    return $self->{_page};
}

sub setPage {
    my ($self, $page) = @_;
    $self->{_page} = $page if defined($page);
}

sub getLang {
    my ($self) = @_;
    return $self->{_lang};
}

sub setLang {
    my ($self, $lang) = @_;
    $self->{_lang} = $lang if defined($lang);
}

sub getPosition {
    my ($self) = @_;
    return $self->{_position};
}

sub setPosition {
    my ($self, $position) = @_;
    $self->{_position} = $position if defined($position);
}

sub getLabelText {
    my ($self) = @_;
    return $self->{_labeltext};
}

sub setLabelText {
    my ($self, $labeltext) = @_;
    $self->{_labeltext} = $labeltext if defined($labeltext);
}
1;
