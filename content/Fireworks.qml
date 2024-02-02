import QtQuick 6.2
import QtQuick.Particles

Item {
    ParticleSystem {
        id: particleSystem
    }

    ImageParticle {
        source: "particle.png"
        system: particleSystem
        color: "white"
        alpha: 0.6
        colorVariation: 0.5
        alphaVariation: 0.2
    }

    Emitter {
        system: particleSystem
        emitRate: 500
        lifeSpan: 2000
        lifeSpanVariation: 1000
        velocity: AngleDirection { angle: 90; angleVariation: 360; magnitude: 100; magnitudeVariation: 50 }
        size: 10
        endSize: 40
    }
}
