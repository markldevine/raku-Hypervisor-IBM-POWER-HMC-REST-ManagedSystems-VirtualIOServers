need    Hypervisor::IBM::POWER::HMC::REST::Config;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Analyze;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Dump;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Optimize;
use     Hypervisor::IBM::POWER::HMC::REST::Config::Traits;
need    Hypervisor::IBM::POWER::HMC::REST::ETL::XML;
unit    class Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::PartitionProcessorConfiguration::CurrentSharedProcessorConfiguration:api<1>:auth<Mark Devine (mark@markdevine.com)>
            does Hypervisor::IBM::POWER::HMC::REST::Config::Analyze
            does Hypervisor::IBM::POWER::HMC::REST::Config::Dump
            does Hypervisor::IBM::POWER::HMC::REST::Config::Optimize
            does Hypervisor::IBM::POWER::HMC::REST::ETL::XML;

my      Bool                                        $names-checked                      = False;
my      Bool                                        $analyzed                           = False;
my      Lock                                        $lock                               = Lock.new;
has     Hypervisor::IBM::POWER::HMC::REST::Config   $.config                            is required;
has     Bool                                        $.initialized                       = False;
has     Str                                         $.AllocatedVirtualProcessors        is conditional-initialization-attribute;
has     Str                                         $.CurrentMaximumProcessingUnits     is conditional-initialization-attribute;
has     Str                                         $.CurrentMinimumProcessingUnits     is conditional-initialization-attribute;
has     Str                                         $.CurrentProcessingUnits            is conditional-initialization-attribute;
has     Str                                         $.CurrentSharedProcessorPoolID      is conditional-initialization-attribute;
has     Str                                         $.CurrentUncappedWeight             is conditional-initialization-attribute;
has     Str                                         $.CurrentMinimumVirtualProcessors   is conditional-initialization-attribute;
has     Str                                         $.CurrentMaximumVirtualProcessors   is conditional-initialization-attribute;
has     Str                                         $.RuntimeProcessingUnits            is conditional-initialization-attribute;
has     Str                                         $.RuntimeUncappedWeight             is conditional-initialization-attribute;

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
    return self                         if $!initialized;
    self.config.diag.post:              self.^name ~ '::' ~ &?ROUTINE.name if %*ENV<HIPH_METHOD>;
    $!AllocatedVirtualProcessors        = self.etl-text(:TAG<AllocatedVirtualProcessors>,       :$!xml) if self.attribute-is-accessed(self.^name, 'AllocatedVirtualProcessors');
    $!CurrentMaximumProcessingUnits     = self.etl-text(:TAG<CurrentMaximumProcessingUnits>,    :$!xml) if self.attribute-is-accessed(self.^name, 'CurrentMaximumProcessingUnits');
    $!CurrentMinimumProcessingUnits     = self.etl-text(:TAG<CurrentMinimumProcessingUnits>,    :$!xml) if self.attribute-is-accessed(self.^name, 'CurrentMinimumProcessingUnits');
    $!CurrentProcessingUnits            = self.etl-text(:TAG<CurrentProcessingUnits>,           :$!xml) if self.attribute-is-accessed(self.^name, 'CurrentProcessingUnits');
    $!CurrentSharedProcessorPoolID      = self.etl-text(:TAG<CurrentSharedProcessorPoolID>,     :$!xml) if self.attribute-is-accessed(self.^name, 'CurrentSharedProcessorPoolID');
    $!CurrentUncappedWeight             = self.etl-text(:TAG<CurrentUncappedWeight>,            :$!xml) if self.attribute-is-accessed(self.^name, 'CurrentUncappedWeight');
    $!CurrentMinimumVirtualProcessors   = self.etl-text(:TAG<CurrentMinimumVirtualProcessors>,  :$!xml) if self.attribute-is-accessed(self.^name, 'CurrentMinimumVirtualProcessors');
    $!CurrentMaximumVirtualProcessors   = self.etl-text(:TAG<CurrentMaximumVirtualProcessors>,  :$!xml) if self.attribute-is-accessed(self.^name, 'CurrentMaximumVirtualProcessors');
    $!RuntimeProcessingUnits            = self.etl-text(:TAG<RuntimeProcessingUnits>,           :$!xml) if self.attribute-is-accessed(self.^name, 'RuntimeProcessingUnits');
    $!RuntimeUncappedWeight             = self.etl-text(:TAG<RuntimeUncappedWeight>,            :$!xml) if self.attribute-is-accessed(self.^name, 'RuntimeUncappedWeight');
    $!xml                               = Nil;
    $!initialized                       = True;
    self;
}

=finish
