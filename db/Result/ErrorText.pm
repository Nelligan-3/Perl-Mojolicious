package My::Schema::Result::ErrorText;
use base qw/DBIx::Class::Core/;
__PACKAGE__->table('errortext');
__PACKAGE__->add_columns(id =>
                          { accessor  => 'errortext',
                            data_type => 'integer',
                            size      => 10,
                            is_nullable => 0,
                            is_auto_increment => 1,
                          },
						  errortext_id =>
                          { data_type => 'integer',
                            size      => 10,
                            is_nullable => 0,
                          },
						  lang  =>
                          { data_type => 'varchar',
                            size      => 3,
                            is_nullable => 0,
                          },
						  errortext  =>
                          { data_type => 'text',
                            is_nullable => 0,
                          },
						);
__PACKAGE__->set_primary_key('id');