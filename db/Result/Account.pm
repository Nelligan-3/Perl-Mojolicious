package My::Schema::Result::Account;
use base qw/DBIx::Class::Core/;
__PACKAGE__->table('account');
__PACKAGE__->add_columns(id =>
                          { accessor  => 'account',
                            data_type => 'integer',
                            size      => 10,
                            is_nullable => 0,
                            is_auto_increment => 1,
                          },
						  accountname  =>
                          { data_type => 'varchar',
                            size      => 20,
                            is_nullable => 0,
                          },
						  password  =>
                          { data_type => 'varchar',
                            size      => 20,
                            is_nullable => 0,
                          },
						  firstname  =>
                          { data_type => 'varchar',
                            size      => 20,
                            is_nullable => 0,
                          },
						  lastname  =>
                          { data_type => 'varchar',
                            size      => 20,
                            is_nullable => 0,
                          }
						);
__PACKAGE__->set_primary_key('id');