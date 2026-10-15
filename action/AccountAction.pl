#!C:\Strawberry\perl\bin\perl.exe
use Crypt::URandom ();
use Crypt::Argon2 ();
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
    my $salt = Crypt::URandom::urandom(16);
    my $encoded = Crypt::Argon2::argon2id_pass($pw, $salt, 3, '32M', 1, 16);
	$self->{_service}->insert($aname, $encoded, $fname, $lname);
	return 2;
  }
}

sub doLogin {
  my ($self, $aname, $pw) = @_;
  my $self->{_service} = My::Schema::AccountRepository->new;
  my @len = $self->{_service}->retrieveAccount($aname);
  $found = @len;
  if(($found > 0) && (Crypt::Argon2::argon2_verify($len[0]->password, $pw))){
	return $len[0]->id;
  } else {
	return 0;
  }
}
