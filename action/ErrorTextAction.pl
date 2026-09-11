#!C:\Strawberry\perl\bin\perl.exe
require './result/ErrorText.pl';
require './service/ErrorTextRepository.pl';
package ErrorTextAction;

sub new {
  my $class = shift;
  my $self = {
    _service => shift,
  };
  return bless $self, $class;
}

sub doGet {
  my ($self, $id, $lang) = @_;
  my $self->{_service} = My::Schema::ErrorTextRepository->new;
  my @errortexts = $self->{_service}->retrieveErrortext($id, $lang);
  my %jsonErrortexts = ();
  foreach my $obj (@errortexts){
	$jsonErrortexts{$obj->errortext_id} = $obj->errortext;
  }
  return %jsonErrortexts;
}