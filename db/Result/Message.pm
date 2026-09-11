package My::Schema::Result::Message;
use base qw/DBIx::Class::Core/;
__PACKAGE__->table('message');
__PACKAGE__->add_columns(id =>
                          { accessor  => 'message',
                            data_type => 'integer',
                            size      => 10,
                            is_nullable => 0,
                            is_auto_increment => 1,
                          },
						  account_id =>
                          { data_type => 'integer',
                            size      => 10,
                            is_nullable => 0,
                          },
						  channel_id =>
                          { data_type => 'integer',
                            size      => 10,
                            is_nullable => 0,
                          },
						  message  =>
                          { data_type => 'text',
                            is_nullable => 0,
                          },
						  creationdate  =>
                          { data_type => 'datetime',
                            is_nullable => 0,
                          },
						);
__PACKAGE__->set_primary_key('id');
__PACKAGE__->belongs_to(account => 'My::Schema::Result::Account', 'account_id');
__PACKAGE__->belongs_to(channel => 'My::Schema::Result::Channel', 'channel_id');