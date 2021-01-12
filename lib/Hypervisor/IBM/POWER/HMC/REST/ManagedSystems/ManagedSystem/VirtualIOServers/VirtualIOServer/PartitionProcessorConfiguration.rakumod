need    Hypervisor::IBM::POWER::HMC::REST::Config;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Analyze;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Dump;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Optimize;
use     Hypervisor::IBM::POWER::HMC::REST::Config::Traits;
need    Hypervisor::IBM::POWER::HMC::REST::ETL::XML;
need    Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::PartitionProcessorConfiguration::SharedProcessorConfiguration;
need    Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::PartitionProcessorConfiguration::CurrentSharedProcessorConfiguration;
unit    class Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::PartitionProcessorConfiguration:api<1>:auth<Mark Devine (mark@markdevine.com)>
            does Hypervisor::IBM::POWER::HMC::REST::Config::Analyze
            does Hypervisor::IBM::POWER::HMC::REST::Config::Dump
            does Hypervisor::IBM::POWER::HMC::REST::Config::Optimize
            does Hypervisor::IBM::POWER::HMC::REST::ETL::XML;

my      Bool                                                                                                                                                                        $names-checked  = False;
my      Bool                                                                                                                                                                        $analyzed       = False;
my      Lock                                                                                                                                                                        $lock           = Lock.new;
has     Hypervisor::IBM::POWER::HMC::REST::Config                                                                                                                                   $.config        is required;
has     Bool                                                                                                                                                                        $.initialized   = False;
has     Str                                                                                                                                                                         $.HasDedicatedProcessors                is conditional-initialization-attribute;
has     Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::PartitionProcessorConfiguration::SharedProcessorConfiguration          $.SharedProcessorConfiguration          is conditional-initialization-attribute;
has     Str                                                                                                                                                                         $.SharingMode                           is conditional-initialization-attribute;
has     Str                                                                                                                                                                         $.CurrentHasDedicatedProcessors         is conditional-initialization-attribute;
has     Str                                                                                                                                                                         $.CurrentSharingMode                    is conditional-initialization-attribute;
has     Str                                                                                                                                                                         $.RuntimeHasDedicatedProcessors         is conditional-initialization-attribute;
has     Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::PartitionProcessorConfiguration::CurrentSharedProcessorConfiguration   $.CurrentSharedProcessorConfiguration   is conditional-initialization-attribute;

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
    return self                                 if $!initialized;
    self.config.diag.post:                      self.^name ~ '::' ~ &?ROUTINE.name if %*ENV<HIPH_METHOD>;
    $!HasDedicatedProcessors                    = self.etl-text(:TAG<HasDedicatedProcessors>,           :$!xml) if self.attribute-is-accessed(self.^name, 'HasDedicatedProcessors');
    if self.attribute-is-accessed(self.^name, 'SharedProcessorConfiguration') {
        $!SharedProcessorConfiguration          = Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::PartitionProcessorConfiguration::SharedProcessorConfiguration.new(:$!config, :xml(self.etl-branch(:TAG<SharedProcessorConfiguration>, :$!xml)));
    }
    $!SharingMode                               = self.etl-text(:TAG<SharingMode>,                      :$!xml) if self.attribute-is-accessed(self.^name, 'SharingMode');
    $!CurrentHasDedicatedProcessors             = self.etl-text(:TAG<CurrentHasDedicatedProcessors>,    :$!xml) if self.attribute-is-accessed(self.^name, 'CurrentHasDedicatedProcessors');
    $!CurrentSharingMode                        = self.etl-text(:TAG<CurrentSharingMode>,               :$!xml) if self.attribute-is-accessed(self.^name, 'CurrentSharingMode');
    $!RuntimeHasDedicatedProcessors             = self.etl-text(:TAG<RuntimeHasDedicatedProcessors>,    :$!xml) if self.attribute-is-accessed(self.^name, 'RuntimeHasDedicatedProcessors');
    if self.attribute-is-accessed(self.^name, 'CurrentSharedProcessorConfiguration') {
        $!CurrentSharedProcessorConfiguration   = Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::PartitionProcessorConfiguration::CurrentSharedProcessorConfiguration.new(:$!config, :xml(self.etl-branch(:TAG<CurrentSharedProcessorConfiguration>, :$!xml)));
    }
    $!xml                                       = Nil;
    $!initialized                               = True;
    self;
}

=finish
