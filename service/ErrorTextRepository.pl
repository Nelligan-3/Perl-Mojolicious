package My::Schema::ErrorTextRepository;
use base qw/DBIx::Class::Schema/;
__PACKAGE__->register_class('ErrorText', 'Result::ErrorText');

sub new {
  my $class = shift;
  my $self = {
    _schema => shift,
  };
  return bless $self, $class;
}

sub retrieveErrortext {
  my ($self, $id, $lang) = @_;
  my $driver   = "SQLite"; 
  my $database = "./db/chatsqlite3.sqlite";
  my $dsn = "DBI:" . $driver . ":dbname=" . $database;
  my $userid = "";
  my $password = "";
  my $self->{_schema} = My::Schema::ErrorTextRepository->connect($dsn, $userid, $password, { RaiseError => 1 }) or die $DBIx::errstr;
  my $rs = $self->{_schema}->resultset('ErrorText')->search({ errortext_id => $id, lang => $lang });
  my @objs = ();
  while(my $row = $rs->next) {
    push(@objs, $row);
  }
  return @objs;
}
1;