#!C:\Strawberry\perl\bin\perl.exe
require './result/Account.pl';
require './service/AccountRepository.pl';
package AccountAction;

sub new {
  my $class = shift;
  my $self = {
    _service => shift,
  };
  return bless $self, $class;
}

sub doInsert {
  my ($self, $id, $aname, $pw, $fname, $lname) = @_;
  my $self->{_service} = My::Schema::AccountRepository->new;
  my @len = $self->{_service}->retrieveAccount($aname);
  $found = @len;
  if($found > 0){
	return 3;
  } else {
	$self->{_service}->insert($aname, $pw, $fname, $lname);
	return 2;
  }
}

sub doLogin {
  my ($self, $aname, $pw) = @_;
  my $self->{_service} = My::Schema::AccountRepository->new;
  my @len = $self->{_service}->retrieveAccount($aname);
  $found = @len;
  if(($found > 0) && ($len[0]->password eq $pw)){
	return $len[0]->id;
  } else {
	return 0;
  }
}