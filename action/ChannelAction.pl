#!C:\Strawberry\perl\bin\perl.exe
require './result/Channel.pl';
require './service/ChannelRepository.pl';
package ChannelAction;

sub new {
  my $class = shift;
  my $self = {
    _service => shift,
  };
  return bless $self, $class;
}

sub doGet {
  my ($self, $lang) = @_;
  my $self->{_service} = My::Schema::ChannelRepository->new;
  return $self->{_service}->retrieveChannels($lang);
}

sub doInsert {
  my ($self, $id, $aid, $name, $lang) = @_;
  my $self->{_service} = My::Schema::ChannelRepository->new;
  $self->{_service}->insert($aid, $name, $lang);
}