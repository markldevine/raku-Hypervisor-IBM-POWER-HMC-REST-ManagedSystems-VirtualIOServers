need    Hypervisor::IBM::POWER::HMC::REST::Config;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Analyze;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Dump;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Optimize;
use     Hypervisor::IBM::POWER::HMC::REST::Config::Traits;
need    Hypervisor::IBM::POWER::HMC::REST::ETL::XML;
unit    class Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::MediaRepositories::VirtualMediaRepository::OpticalMedia::VirtualOpticalMedia:api<1>:auth<Mark Devine (mark@markdevine.com)>
            does Hypervisor::IBM::POWER::HMC::REST::Config::Analyze
            does Hypervisor::IBM::POWER::HMC::REST::Config::Dump
            does Hypervisor::IBM::POWER::HMC::REST::Config::Optimize
            does Hypervisor::IBM::POWER::HMC::REST::ETL::XML;

my      Bool                                        $names-checked  = False;
my      Bool                                        $analyzed       = False;
my      Lock                                        $lock           = Lock.new;
has     Hypervisor::IBM::POWER::HMC::REST::Config   $.config        is required;
has     Bool                                        $.initialized   = False;
has     Str                                         $.MediaName     is conditional-initialization-attribute;
has     Str                                         $.MediaUDID     is conditional-initialization-attribute;
has     Str                                         $.MountType     is conditional-initialization-attribute;
has     Str                                         $.Size          is conditional-initialization-attribute;

method  xml-name-exceptions () { return set <Metadata>; }

submethod TWEAK {
    self.config.diag.post:      self.^name ~ '::' ~ &?ROUTINE.name if %*ENV<HIPH_SUBMETHOD>;
    my $proceed-with-name-check = False;
    my $proceed-with-analyze    = False;
    $lock.protect({
        if !$analyzed           { $proceed-with-analyze    = True; $analyzed      = True; }
        if !$names-checked      { $proceed-with-name-check = True; $names-checked = True; }
    });
    self.etl-node-name-check    if $proceed-with-name-check;
    self.init;
    self.analyze                if $proceed-with-analyze;
    self;
}

method init () {
    return self             if $!initialized;
    self.config.diag.post:  self.^name ~ '::' ~ &?ROUTINE.name if %*ENV<HIPH_METHOD>;
    $!MediaName             = self.etl-text(:TAG<MediaName>,    :$!xml) if self.attribute-is-accessed(self.^name, 'MediaName');
    $!MediaUDID             = self.etl-text(:TAG<MediaUDID>,    :$!xml) if self.attribute-is-accessed(self.^name, 'MediaUDID');
    $!MountType             = self.etl-text(:TAG<MountType>,    :$!xml) if self.attribute-is-accessed(self.^name, 'MountType');
    $!Size                  = self.etl-text(:TAG<Size>,         :$!xml) if self.attribute-is-accessed(self.^name, 'Size');
    $!xml                   = Nil;
    $!initialized           = True;
    self;
}

=finish
