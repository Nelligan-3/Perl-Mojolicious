#!C:\Strawberry\perl\bin\perl.exe
require './result/Message.pl';
require './service/MessageRepository.pl';
require './result/Account.pl';
require './service/AccountRepository.pl';
package MessageAction;

sub new {
  my $class = shift;
  my $self = {
    _service => shift,
  };
  return bless $self, $class;
}

sub doGet {
  my ($self, $channelId) = @_;
  my $accountService = My::Schema::AccountRepository->new;
  my $self->{_service} = My::Schema::MessageRepository->new;
  return $self->{_service}->retrieveMessages($channelId);
}

sub doInsert {
  my ($self, $id, $aid, $cid, $message) = @_;
  my $self->{_service} = My::Schema::MessageRepository->new;
  $self->{_service}->insert($aid, $cid, $message);
}