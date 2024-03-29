use ExtUtils::MakeMaker;

my $preop =
    'perl -MPod::Markdown -e \'Pod::Markdown->new->filter(@ARGV)\' $(VERSION_FROM) | tee $(DISTVNAME)/README > README.md;' .
    'pod2text $(VERSION_FROM) | tee $(DISTVNAME)/README > README;';

WriteMakefile(
              'NAME'         => 'apid',
              'VERSION_FROM' => 'bin/apid', # finds $VERSION
              'EXE_FILES'    => [ 'bin/apid' ],
	      'PREREQ_PM'    => {
				 'CGI::Cookie' => 0,
				 'Config::General' => 0,
				 'Crypt::Random' => 0,
				 'DB_File' => 0,
				 'Daemon::Generic' => 0,
				 'Data::Dumper' => 0,
				 'Data::Validate::Struct' => 0,
				 'Digest::SHA' => 0,
				 'HTTP::Daemon' => 0,
				 'HTTP::Daemon::SSL' => 0,
				 'HTTP::Request::Params' => 0,
				 'JSON' => 0,
				 'MIME::Base64' => 0,
				 'URI::Escape' => 0,
				},
	      'META_MERGE' => {
			       resources => {
					     repository => 'https://github.com/TLINDEN/apid',
					    },
			      },
	      ($ExtUtils::MakeMaker::VERSION ge '6.31'? ('LICENSE'              => 'perl', ) : ()),
	      'clean'        => { FILES => 't/*.out t/test.cfg *~ */*~' },
	      MAN3PODS => {},
	      dist                => {
				      COMPRESS => 'gzip -9f',
				      SUFFIX => 'gz',
				      PREOP => $preop,
				     },
);
