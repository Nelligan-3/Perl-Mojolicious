package Result::LabelText;
use base qw/DBIx::Class::Core/;
__PACKAGE__->table('labeltext');
__PACKAGE__->add_columns(id =>
                          { accessor  => 'labeltext',
                            data_type => 'integer',
                            size      => 10,
                            is_nullable => 0,
                            is_auto_increment => 1,
                          },
						  page =>
                          { data_type => 'varchar',
                            size      => 20,
                            is_nullable => 0,
                          },
						  lang  =>
                          { data_type => 'varchar',
                            size      => 3,
                            is_nullable => 0,
                          },
						  position =>
                          { data_type => 'varchar',
                            size      => 20,
                            is_nullable => 0,
                          },
						  labeltext  =>
                          { data_type => 'varchar',
                            size      => 255,
                            is_nullable => 0,
                          },
						);
__PACKAGE__->set_primary_key('id');
