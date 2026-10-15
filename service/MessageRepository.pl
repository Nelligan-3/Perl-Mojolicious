package My::Schema::MessageRepository;
use base qw/DBIx::Class::Schema/;
__PACKAGE__->register_class('Message', 'Result::Message');
__PACKAGE__->register_class('Account', 'Result::Account');
use DateTime;

sub new {
  my $class = shift;
  my $self = {
    _schema => shift,
  };
  return bless $self, $class;
}

sub insert {
  my ($self, $aid, $cid, $message) = @_;
  my $driver   = "SQLite"; 
  my $database = "./db/chatsqlite3.sqlite";
  my $dsn = "DBI:" . $driver . ":dbname=" . $database;
  my $userid = "";
  my $password = "";
  my $self->{_schema} = My::Schema::MessageRepository->connect($dsn, $userid, $password, { RaiseError => 1 }) or die $DBIx::errstr;
  $self->{_schema}->resultset('Message')->create({
    account_id => $aid,
    channel_id => $cid,
    message  => $message,
    creationdate => DateTime->now
  });
}

sub retrieveMessages {
  my ($self, $channel_id) = @_;
  my $driver   = "SQLite"; 
  my $database = "./db/chatsqlite3.sqlite";
  my $dsn = "DBI:" . $driver . ":dbname=" . $database;
  my $userid = "";
  my $password = "";
  my $self->{_schema} = My::Schema::MessageRepository->connect($dsn, $userid, $password, { RaiseError => 1 }) or die $DBIx::errstr;
  my $rs = $self->{_schema}->resultset('Message')->search({ channel_id => $channel_id });
  my %jsonMessages = ();
  while(my $message = $rs->next) {
    my %jsonMessage = ();
    my $ra = $self->{_schema}->resultset('Account')->search({ id => $message->account_id });
	@account = $ra->next;
    $found = @account;
	if ($found > 0) {
      $jsonMessage{'accountname'} = $account[0]->accountname;
      $jsonMessage{'time'} = $message->creationdate;
      $jsonMessage{'message'} = $message->message;
      $jsonMessages{$message->id} = \%jsonMessage;
	} else {
      $jsonMessage{'accountname'} = $message->id;
      $jsonMessage{'time'} = $message->creationdate;
      $jsonMessage{'message'} = $message->message;
      $jsonMessages{$message->id} = \%jsonMessage;
	}
  }
  return %jsonMessages;
}
1;