use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME'         => 'Catalyst::Plugin::DefaultEnd',
    'VERSION_FROM' => 'lib/Catalyst/Plugin/DefaultEnd.pm',
    'PREREQ_PM'    => {
        Catalyst                 => 0,
    }
);
