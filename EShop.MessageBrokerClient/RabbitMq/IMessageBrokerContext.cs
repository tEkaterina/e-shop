﻿using EShop.MessageBrokerClient.Configuration;

namespace EShop.MessageBrokerClient.RabbitMq;

internal interface IMessageBrokerContext : IDisposable, IAsyncDisposable
{
    IChannel GetChannel();

    Task InitializeAsync(CancellationToken token = default);

    Task PublishAsync(string pipelineName, byte[] message);

    Task SubscribeAsync(string pipelineName, IAsyncBasicConsumer consumer);
}
