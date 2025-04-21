from enum import Enum
from typing import Any, Optional
from typing import Any, List, Optional, Sequence, Union
from flet.core.constrained_control import ConstrainedControl
from flet.core.control import OptionalNumber



class HyperEffectsType(Enum):
    ROLL = "roll"
    TRANSLATE = "translate"

class HyperEffectsRoll(ConstrainedControl):
    """
    HyperEffectsRoll Control for animated rolling text.
    """

    def __init__(
        self,
        #
        # Control
        #
        size: OptionalNumber = None,
        opacity: OptionalNumber = None,
        tooltip: Optional[str] = None,
        visible: Optional[bool] = None,
        data: Any = None,
        #
        # ConstrainedControl
        #
        left: OptionalNumber = None,
        top: OptionalNumber = None,
        right: OptionalNumber = None,
        bottom: OptionalNumber = None,
        #
        # HyperEffectsRoll specific
        #
        value: Optional[str] = None,
        effect_type: Optional[HyperEffectsType] = HyperEffectsType.ROLL,
        font: Optional[str] = None,
    ):
        ConstrainedControl.__init__(
            self,
            tooltip=tooltip,
            opacity=opacity,
            visible=visible,
            data=data,
            left=left,
            top=top,
            right=right,
            bottom=bottom,
        )

        self.size = size
        self.value = value
        self.effect_type = effect_type
        self.font = font

    def _get_control_name(self):
        return "flet_hyper_effects_roll"
    
    # size
    @property
    def size(self) -> OptionalNumber:
        return self._get_attr("size", data_type="float")

    @size.setter
    def size(self, value: OptionalNumber):
        self._set_attr("size", value)
        
    # value
    @property
    def value(self) -> Optional[str]:
        """
        Current value to display. If changed, triggers an animation 
        from the current word to this new value.
        """
        return self._get_attr("value")

    @value.setter
    def value(self, value: Optional[str]):
        self._set_attr("value", value)
        
    # effect_type
    @property
    def effect_type(self) -> Optional[HyperEffectsType]:
        """
        Type of effect animation: ROLL or TRANSLATE
        """
        return self._get_attr("effectType")

    @effect_type.setter
    def effect_type(self, value: Optional[HyperEffectsType]):
        if value is not None:
            self._set_attr("effectType", value.value)
        else:
            self._set_attr("effectType", HyperEffectsType.ROLL.value)
    
    # font
    @property
    def font(self) -> Optional[str]:
        """
        Google Font to use for the text.
        Example: 'Roboto', 'Pacifico', 'Montserrat'
        """
        return self._get_attr("font")

    @font.setter
    def font(self, value: Optional[str]):
        self._set_attr("font", value)
