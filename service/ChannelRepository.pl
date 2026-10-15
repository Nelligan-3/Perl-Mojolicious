package My::Schema::ChannelRepository;
use base qw/DBIx::Class::Schema/;
__PACKAGE__->register_class('Channel', 'Result::Channel');

sub new {
  my $class = shift;
  my $self = {
    _schema => shift,
  };
  return bless $self, $class;
}

sub insert {
  my ($self, $aid, $name, $lang) = @_;
  my $driver   = "SQLite"; 
  my $database = "./db/chatsqlite3.sqlite";
  my $dsn = "DBI:" . $driver . ":dbname=" . $database;
  my $userid = "";
  my $password = "";
  my $self->{_schema} = My::Schema::ChannelRepository->connect($dsn, $userid, $password, { RaiseError => 1 }) or die $DBIx::errstr;
  $self->{_schema}->resultset('Channel')->create({
    account_id => $aid,
    name => $name,
    creationdate => DateTime->now,
    lang => $lang
  });
}

sub retrieveChannel {
  my ($self, $name, $lang) = @_;
  my $driver   = "SQLite"; 
  my $database = "./db/chatsqlite3.sqlite";
  my $dsn = "DBI:" . $driver . ":dbname=" . $database;
  my $userid = "";
  my $password = "";
  my $self->{_schema} = My::Schema::ChannelRepository->connect($dsn, $userid, $password, { RaiseError => 1 }) or die $DBIx::errstr;
  my $rs = $self->{_schema}->resultset('Channel')->search({ name => $name, lang => $lang });
  my @objs = ();
  while(my $row = $rs->next) {
    push(@objs, $row);
  }
  return @objs;
}

sub retrieveChannels {
  my ($self, $lang) = @_;
  my $driver   = "SQLite"; 
  my $database = "./db/chatsqlite3.sqlite";
  my $dsn = "DBI:" . $driver . ":dbname=" . $database;
  my $userid = "";
  my $password = "";
  my $self->{_schema} = My::Schema::ChannelRepository->connect($dsn, $userid, $password, { RaiseError => 1 }) or die $DBIx::errstr;
  my $rs = $self->{_schema}->resultset('Channel')->search({ lang => $lang });
  my %jsonChannels = ();
  while(my $row = $rs->next) {
	$jsonChannels{$row->id} = $row->name;
  }
  return %jsonChannels;
}
1;