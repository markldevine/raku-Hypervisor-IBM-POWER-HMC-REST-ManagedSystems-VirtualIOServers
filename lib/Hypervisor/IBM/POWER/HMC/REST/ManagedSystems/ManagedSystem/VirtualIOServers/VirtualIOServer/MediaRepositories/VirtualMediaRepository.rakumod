need    Hypervisor::IBM::POWER::HMC::REST::Config;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Analyze;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Dump;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Optimize;
use     Hypervisor::IBM::POWER::HMC::REST::Config::Traits;
need    Hypervisor::IBM::POWER::HMC::REST::ETL::XML;
need    Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::MediaRepositories::VirtualMediaRepository::OpticalMedia;
unit    class Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::MediaRepositories::VirtualMediaRepository:api<1>:auth<Mark Devine (mark@markdevine.com)>
            does Hypervisor::IBM::POWER::HMC::REST::Config::Analyze
            does Hypervisor::IBM::POWER::HMC::REST::Config::Dump
            does Hypervisor::IBM::POWER::HMC::REST::Config::Optimize
            does Hypervisor::IBM::POWER::HMC::REST::ETL::XML;

my      Bool                                                                                                                                                            $names-checked      = False;
my      Bool                                                                                                                                                            $analyzed           = False;
my      Lock                                                                                                                                                            $lock               = Lock.new;
has     Hypervisor::IBM::POWER::HMC::REST::Config                                                                                                                       $.config            is required;
has     Bool                                                                                                                                                            $.initialized       = False;
has     Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::MediaRepositories::VirtualMediaRepository::OpticalMedia    $.OpticalMedia      is conditional-initialization-attribute;
has     Str                                                                                                                                                             $.RepositoryName    is conditional-initialization-attribute;
has     Str                                                                                                                                                             $.RepositorySize    is conditional-initialization-attribute;

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
    if self.attribute-is-accessed(self.^name, 'OpticalMedia') {
        $!OpticalMedia      = Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::MediaRepositories::VirtualMediaRepository::OpticalMedia.new(:$!config, :xml(self.etl-branch(:TAG<OpticalMedia>, :$!xml, :optional)));
    }
    $!RepositoryName        = self.etl-text(:TAG<RepositoryName>, :$!xml, :optional)    if self.attribute-is-accessed(self.^name, 'RepositoryName');
    $!RepositorySize        = self.etl-text(:TAG<RepositorySize>, :$!xml, :optional)    if self.attribute-is-accessed(self.^name, 'RepositorySize');
    $!xml                   = Nil;
    $!initialized           = True;
    self;
}

=finish
