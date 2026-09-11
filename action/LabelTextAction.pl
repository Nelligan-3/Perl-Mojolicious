#!C:\Strawberry\perl\bin\perl.exe
require './result/LabelText.pl';
require './service/LabelTextRepository.pl';
package LabelTextAction;

sub new {
  my $class = shift;
  my $self = {
    _service => shift,
  };
  return bless $self, $class;
}

sub doGet {
  my ($self, $page, $lang) = @_;
  my $self->{_service} = My::Schema::LabelTextRepository->new;
  return $self->{_service}->retrieveLabelTexts($page, $lang);
}
