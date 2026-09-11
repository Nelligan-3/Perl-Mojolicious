package My::Schema::Result::Channel;
use base qw/DBIx::Class::Core/;
__PACKAGE__->table('channel');
__PACKAGE__->add_columns(id =>
                          { accessor  => 'channel',
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
						  name  =>
                          { data_type => 'varchar',
                            size      => 30,
                            is_nullable => 0,
                          },
						  lang  =>
                          { data_type => 'varchar',
                            size      => 3,
                            is_nullable => 0,
                          },
						);
__PACKAGE__->set_primary_key('id');
__PACKAGE__->belongs_to(account => 'My::Schema::Result::Account', 'account_id');