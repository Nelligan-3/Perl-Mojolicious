package My::Schema::AccountRepository;
use base qw/DBIx::Class::Schema/;
__PACKAGE__->register_class('Account', 'Result::Account');

sub new {
  my $class = shift;
  my $self = {
    _schema => shift,
  };
  return bless $self, $class;
}

sub insert {
  my ($self, $aname, $pw, $fname, $lname) = @_;
  my $driver   = "SQLite"; 
  my $database = "./db/chatsqlite3.sqlite";
  my $dsn = "DBI:" . $driver . ":dbname=" . $database;
  my $userid = "";
  my $password = "";
  my $self->{_schema} = My::Schema::AccountRepository->connect($dsn, $userid, $password, { RaiseError => 1 }) or die $DBIx::errstr;
  $self->{_schema}->resultset('Account')->create({
    accountname  => $aname,
    password => $pw,
    firstname  => $fname,
    lastname => $lname,
    creationdate => DateTime->now
  });
}

sub retrieveAccount {
  my ($self, $accountname) = @_;
  my $driver   = "SQLite"; 
  my $database = "./db/chatsqlite3.sqlite";
  my $dsn = "DBI:" . $driver . ":dbname=" . $database;
  my $userid = "";
  my $password = "";
  my $self->{_schema} = My::Schema::AccountRepository->connect($dsn, $userid, $password, { RaiseError => 1 }) or die $DBIx::errstr;
  my $rs = $self->{_schema}->resultset('Account')->search({ accountname => $accountname });
  my @objs = ();
  while(my $row = $rs->next) {
    push(@objs, $row);
  }
  return @objs;
}

sub retrieveAccountById {
  my ($self, $id) = @_;
  my $driver   = "SQLite"; 
  my $database = "./db/chatsqlite3.sqlite";
  my $dsn = "DBI:" . $driver . ":dbname=" . $database;
  my $userid = "";
  my $password = "";
  my $self->{_schema} = My::Schema::AccountRepository->connect($dsn, $userid, $password, { RaiseError => 1 }) or die $DBIx::errstr;
  my $rs = $self->{_schema}->resultset('Account')->search({ id => $id });
  my @objs = ();
  while(my $row = $rs->next) {
    push(@objs, $row);
  }
  return @objs;
}
1;