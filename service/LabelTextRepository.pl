package My::Schema::LabelTextRepository;
use base qw/DBIx::Class::Schema/;
__PACKAGE__->register_class('LabelText', 'Result::LabelText');

sub new {
  my $class = shift;
  my $self = {
    _schema => shift,
  };
  return bless $self, $class;
}

sub retrieveLabelTexts {
  my ($self, $page, $lang) = @_;
  my $driver   = "SQLite"; 
  my $database = "./db/chatsqlite3.sqlite";
  my $dsn = "DBI:" . $driver . ":dbname=" . $database;
  my $userid = "";
  my $password = "";
  my $self->{_schema} = My::Schema::LabelTextRepository->connect($dsn, $userid, $password, { RaiseError => 1 }) or die $DBIx::errstr;
  my $rs = $self->{_schema}->resultset('LabelText')->search({ page => $page, lang => $lang });
  my %jsonLabelTexts = {};
  while(my $row = $rs->next) {
	$jsonLabelTexts{$row->position} = $row->labeltext;
  }
  return %jsonLabelTexts;
}
1;
